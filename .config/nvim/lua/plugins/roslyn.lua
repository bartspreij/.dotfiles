return {
    "seblj/roslyn.nvim",
    ft = "cs",
    opts = {
        config = {
            settings = {
                ['csharp|navigation'] = {
                    dotnet_navigate_to_decompiled_sources = true,
                },
                ['csharp|symbol_search'] = {
                    dotnet_search_reference_assemblies = true,
                },
                ['csharp|quick_info'] = {
                    dotnet_show_remarks_in_quick_info = true,
                },
                ['csharp|highlighting'] = {
                    dotnet_highlight_related_json_components = true,
                    dotnet_highlight_related_regex_components = true,
                },
                ['csharp|completion'] = {
                    dotnet_provide_regex_completions = true,
                    dotnet_show_completion_items_from_unimported_namespaces = true,
                    dotnet_show_name_completion_suggestions = true,
                },
                ['csharp|code_lens'] = {
                    dotnet_enable_references_code_lens = true,
                    dotnet_enable_tests_code_lens = true,
                },
                ['csharp|inlay_hints'] = {
                    csharp_enable_inlay_hints_for_implicit_object_creation = true,
                    csharp_enable_inlay_hints_for_implicit_variable_types = true,
                    csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                    csharp_enable_inlay_hints_for_types = true,
                    dotnet_enable_inlay_hints_for_indexer_parameters = true,
                    dotnet_enable_inlay_hints_for_literal_parameters = true,
                    dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                    dotnet_enable_inlay_hints_for_other_parameters = true,
                    dotnet_enable_inlay_hints_for_parameters = true,
                },
            },
        },
    },
}
