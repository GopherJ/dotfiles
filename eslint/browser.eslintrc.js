module.exports = {
    env: {
        browser: true,
        es2021: true,
    },
    extends: ["plugin:vue/essential", "airbnb-base"],
    parserOptions: {
        ecmaVersion: 12,
        parser: "@typescript-eslint/parser",
        sourceType: "module",
    },
    plugins: ["vue", "@typescript-eslint"],
    rules: {
        indent: ["error", 4],
        quotes: ["error", "double"],
        semi: ["error", "always"],
        "no-console": "warn",
        "no-unused-vars": "warn",
        "no-useless-catch": "warn",
        "no-undef": "error",
        "arrow-parens": 0,
    },
}
