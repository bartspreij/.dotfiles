import { html } from "uhtml"
import DOMPurify from "dompurify"

import api from "./api.js"

const { Hints, RUNTIME } = api

const util = {}

const promisify = (fn) => (...args) =>
  new Promise((resolve, reject) => {
    try {
      fn(...args, resolve)
    } catch (e) {
      reject(e)
    }
  })
util.promisify = promisify

const runtime = promisify(RUNTIME)
util.runtime = runtime

util.runtimeHttpRequest = async (url, opts) => {
  const res = await runtime("request", { ...opts, url })
  return res.text
}

util.getURLPath = ({ count = 0, domain = false } = {}) => {
  let path = window.location.pathname.slice(1)
  if (count) {
    path = path.split("/").slice(0, count).join("/")
  }
  if (domain) {
    path = `${window.location.hostname}/${path}`
  }
  return path
}

util.getMap = (mode, keys) =>
  keys.split("").reduce((acc, c) => acc[c] || acc, mode.mappings).meta || null

util.escapeHTML = (text) => {
  const el = document.createElement("span")
  el.textContent = text
  return el.innerHTML
}

// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions#Escaping
util.escapeRegExp = (str) => str.replace(/[.*+\-?^${}()|[\]\\]/g, "\\$&")

util.until = (check, test = (a) => a, maxAttempts = 50, interval = 50) =>
  new Promise((resolve, reject) => {
    const f = (attempts = 0) => {
      const res = check()
      if (!test(res)) {
        if (attempts > maxAttempts) {
          reject(new Error("until: timeout"))
        } else {
          setTimeout(() => f(attempts + 1), interval)
        }
        return
      }
      resolve(res)
    }
    f()
  })

const localStorageFns = () => {
  if (typeof browser !== "undefined") {
    return [browser.storage.local.get, browser.storage.local.set]
  }
  if (typeof chrome !== "undefined") {
    return [chrome.storage.local.get, chrome.storage.local.set].map((fn) =>
      util.promisify(fn.bind(chrome.storage.local))
    )
  }
  const fn = () =>
    new Error("local storage unavailable: unsupported environment")
  return [fn, fn]
}

const [localStorageGet, localStorageSet] = localStorageFns()

util.localStorage = {}

util.localStorage.fullkey = (key) => `surfingkeys-conf.${key}`

util.localStorage.get = async (key) => {
  const fullkey = util.localStorage.fullkey(key)
  return (await localStorageGet(fullkey))[fullkey]
}

util.localStorage.set = async (key, val) => {
  const fullkey = util.localStorage.fullkey(key)
  const storageObj = { [fullkey]: val }
  return localStorageSet(storageObj)
}

util.htmlUnsafe = (content) => html.node([content])

util.htmlPurify = (content, config = { USE_PROFILES: { html: true } }) =>
  util.htmlUnsafe(DOMPurify.sanitize(content, config))

util.htmlNode = (template, ...values) => html.node(template, ...values)

util.htmlForEach = (items) => items.map((item) => html.for(item)`${item}`)

util.html = (template, ...values) =>
  util.htmlNode(template, ...values).outerHTML

util.suggestionItem = (props = {}) => (template, ...values) => ({
  html: util.html(template, ...values),
  props,
})

util.urlItem = (title, url, { desc = null, query = null } = {}) => {
  const descItems =
    desc && desc.length > 0
      ? (Array.isArray(desc) ? desc : [desc]).map(
          (d) => util.htmlNode`<div>${d}</div>`
        )
      : []
  return util.suggestionItem({ url: url, query: query ?? title })`
    <div>
      <div style="font-weight: bold">${title}</div>
      ${util.htmlForEach(descItems)}
      <div style="opacity: 0.7; line-height: 1.3em">${url}</div>
    </div>
  `
}

util.defaultSelector = "a[href]:not([href^=javascript])"

util.querySelectorFiltered = (
  selector = util.defaultSelector,
  filter = () => true
) => [...document.querySelectorAll(selector)].filter(filter)

util.createHints = (
  selector = util.defaultSelector,
  action = Hints.dispatchMouseClick,
  attrs = {}
) =>
  new Promise((resolve) => {
    Hints.create(
      selector,
      (...args) => {
        resolve(...args)
        if (typeof action === "function") action(...args)
      },
      attrs
    )
  })

util.createHintsFiltered = (filter, selector, ...args) => {
  util.createHints(util.querySelectorFiltered(selector, filter), ...args)
}

// https://developer.mozilla.org/en-US/docs/web/api/element/getboundingclientrect
util.isRectVisibleInViewport = (rect) =>
  rect.height > 0 &&
  rect.width > 0 &&
  rect.bottom >= 0 &&
  rect.right >= 0 &&
  rect.top <= (window.innerHeight || document.documentElement.clientHeight) &&
  rect.left <= (window.innerWidth || document.documentElement.clientWidth)

util.isElementInViewport = (e) =>
  e.offsetHeight > 0 &&
  e.offsetWidth > 0 &&
  !e.getAttribute("disabled") &&
  util.isRectVisibleInViewport(e.getBoundingClientRect())

util.getDuckduckgoFaviconUrl = (url) => {
  const u = url instanceof URL ? url : new URL(url)
  return new URL(`https://icons.duckduckgo.com/ip3/${u.hostname}.ico`).href
}

// Originally based on JavaScript Pretty Date
// https://johnresig.com/blog/javascript-pretty-date/
// Copyright (c) 2011 John Resig (ejohn.org)
// Licensed under the MIT and GPL licenses.
util.prettyDate = (date) => {
  const diff = (new Date().getTime() - date.getTime()) / 1000
  const dayDiff = Math.floor(diff / 86400)
  if (Number.isNaN(dayDiff) || dayDiff < 0) return ""
  const [count, unit] = (dayDiff === 0 &&
    ((diff < 60 && [null, "just now"]) ||
      (diff < 3600 && [Math.floor(diff / 60), "minute"]) ||
      (diff < 86400 && [Math.floor(diff / 3600), "hour"]))) ||
    (dayDiff === 1 && [null, "yesterday"]) ||
    (dayDiff < 7 && [dayDiff, "day"]) ||
    (dayDiff < 30 && [Math.round(dayDiff / 7), "week"]) ||
    (dayDiff < 365 && [Math.round(dayDiff / 30), "month"]) || [
      Math.round(dayDiff / 365),
      "year",
    ]
  return `${count ?? ""}${count ? " " : ""}${unit}${
    (count ?? 0) > 1 ? "s" : ""
  }${count ? " ago" : ""}`
}

export default util
