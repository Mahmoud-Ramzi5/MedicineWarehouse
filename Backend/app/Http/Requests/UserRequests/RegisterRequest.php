<?php

namespace App\Http\Requests\UserRequests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;

class RegisterRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'phoneNumber' => 'numeric|required|digits:9|unique:App\Models\User,phoneNumber',
            'email' => 'email|nullable|unique:App\Models\User,email',
            'pharmacyName' => 'required',
            'pharmacyAddress' => 'required',
            'password' => 'required',
            'confirmPassword' => 'required',
        ];
    }


    /**
     * Handle a failed validation attempt.
     *
     * @param  \Illuminate\Contracts\Validation\Validator  $validator
     * @return void
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    protected function failedValidation(Validator $validator)
    {
        $exception = $validator->getException();

        $response = response()->json([
                'message' => 'Invalid credentials',
                'errors' => $validator->errors()
        ], 400);

        throw (new $exception($validator, $response))
                    ->errorBag($this->errorBag);
    }
}
