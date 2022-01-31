<?php

declare(strict_types=1);

use PhpCsFixer\Config;
use PhpCsFixer\Finder;

$finder = Finder::create()
    ->in([
        __DIR__ . '/src',
        __DIR__ . '/tests',
    ])
    ->append([
        __FILE__,
    ])
;

return
    (new Config())
        ->setCacheFile(__DIR__ . '/var/cache/.php_cs')
        ->setFinder($finder)
        ->setRules([
            '@Symfony' => true,
            'array_syntax' => ['syntax' => 'short'],
            'class_definition' => ['multiLineExtendsEachSingleLine' => true],
            'no_useless_else' => true,
            'phpdoc_add_missing_param_annotation' => ['only_untyped' => true],
            'echo_tag_syntax' => ['format' => 'long'],
            'list_syntax' => ['syntax' => 'short'],
            'linebreak_after_opening_tag' => true,
            'void_return' => false,
            'phpdoc_summary' => false,
            'multiline_whitespace_before_semicolons' => ['strategy' => 'new_line_for_chained_calls'],
            'visibility_required' => ['property', 'method', 'const'],

            '@PSR12' => true,
            '@PSR12:risky' => true,
            '@PHP80Migration' => true,
            '@PHP80Migration:risky' => true,
            '@PHPUnit84Migration:risky' => true,
            '@PhpCsFixer' => true,
            '@PhpCsFixer:risky' => true,

            'ordered_imports' => ['imports_order' => ['class', 'function', 'const']],

            'concat_space' => ['spacing' => 'one'],
            'cast_spaces' => ['space' => 'none'],
            'binary_operator_spaces' => false,

            'phpdoc_to_comment' => false,
            'phpdoc_separation' => false,
            'phpdoc_types_order' => ['null_adjustment' => 'always_last'],
            'phpdoc_align' => false,

            'operator_linebreak' => false,

            'global_namespace_import' => true,

            'blank_line_before_statement' => false,

            'fopen_flags' => ['b_mode' => true],

            'php_unit_strict' => false,
            'php_unit_test_class_requires_covers' => false,
            'php_unit_test_case_static_method_calls' => ['call_type' => 'self'],

            'yoda_style' => false,

            'final_class' => true,
            'final_public_method_for_abstract_class' => true,
            'self_static_accessor' => true,

            'static_lambda' => true,
        ])
    ;
