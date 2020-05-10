{
    "env": {
        "browser": true,
        "es6": true,
        "node": true
    },
    "extends": [
        "airbnb-base"
    ],
    "plugins": [
        "jest",
        "svelte3"
    ],
    "overrides": [
        {
            "files": ["**/*.svelte"],
            "processor": "svelte3/svelte3",
            "rules": {
                "import/first": "off",
                "import/no-extraneous-dependencies": "off",
                "import/no-mutable-exports": "off",
                "import/prefer-default-export": "off",
                "no-multiple-empty-lines": "off"
            }
        },
        {
            "files": ["**/*.test.js"],
            "env": {
                "jest": true
            }
        }
    ],
    "globals": {
        "Atomics": "readonly",
        "SharedArrayBuffer": "readonly"
    },
    "parserOptions": {
        "ecmaVersion": 2018,
        "sourceType": "module"
    },
    "rules": {
        "arrow-parens": ["error", "as-needed"],
        "indent": ["error", 2, {"flatTernaryExpressions": true}],
        "no-multi-spaces": ["error", {"exceptions": { "ConditionalExpression": true }}],
        "no-nested-ternary": "off",
        "object-curly-newline": ["error", {"consistent": true}],
        "object-curly-spacing": ["error", "always"],
        "semi": ["error", "never"]
    }
}
