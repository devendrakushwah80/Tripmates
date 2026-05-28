<?php
namespace App\Helpers;

final class Validator
{
    public static function validate(array $data, array $rules): array
    {
        $errors = [];
        foreach ($rules as $field => $ruleString) {
            $value = $data[$field] ?? null;
            foreach (explode('|', $ruleString) as $rule) {
                [$name, $param] = array_pad(explode(':', $rule, 2), 2, null);
                if ($name === 'required' && ($value === null || $value === '')) {
                    $errors[$field][] = "{$field} is required";
                }
                if ($value === null || $value === '') {
                    continue;
                }
                if ($name === 'email' && !filter_var($value, FILTER_VALIDATE_EMAIL)) {
                    $errors[$field][] = "{$field} must be a valid email";
                }
                if ($name === 'min' && strlen((string) $value) < (int) $param) {
                    $errors[$field][] = "{$field} must be at least {$param} characters";
                }
                if ($name === 'max' && strlen((string) $value) > (int) $param) {
                    $errors[$field][] = "{$field} may not exceed {$param} characters";
                }
                if ($name === 'in' && !in_array($value, explode(',', (string) $param), true)) {
                    $errors[$field][] = "{$field} is invalid";
                }
                if ($name === 'int' && filter_var($value, FILTER_VALIDATE_INT) === false) {
                    $errors[$field][] = "{$field} must be an integer";
                }
            }
        }
        return $errors;
    }
}
