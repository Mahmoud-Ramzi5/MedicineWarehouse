<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
class MedicineRequest extends FormRequest
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
            'expiry_date' => 'required',
            'quantity_available' => 'required',
            'price' => 'required|min:0',
            'en_commercial_name' => 'required|max:255',
            'ar_commercial_name' => 'required|max:255',
            'en_scientific_name' => 'required|max:255',
            'ar_scientific_name' => 'required|max:255',
            'en_manufacture_company' => 'required',
            'ar_manufacture_company' => 'required',
            'category_ids' => 'required',
            'image_path' => 'required',
            'image' => 'nullable'
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


