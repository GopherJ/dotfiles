module.exports = {
    root: true,
    // parser: '@typescript-eslint/parser',
    // plugins: ['@typescript-eslint'],
    parserOptions: {
        ecmaVersion: 2018,
        sourceType: 'module',
    },
    extends: [
        // "plugin:vue/essential",
        // "plugin:prettier/recommended"
        // "@vue/airbnb",
        'eslint:recommended',
    ],
    env: {
        browser: true,
        node: true,
        es6: true,
    },
    rules: {
        indent: ['error', 4],
        quotes: ['error', 'double'],
        semi: ['error', 'always'],
        'no-console': 'warn',
        'no-unused-vars': 'warn',
        'no-useless-catch': 'warn',
        'no-undef': 'error',
        'arrow-parens': 0,
    },
}
