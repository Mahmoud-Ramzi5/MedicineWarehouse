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
            'Expiry_date' => 'required',
            'Quantity_available' => 'required',
            'Price' => 'required|min:0',
            'En_Commercial_name' => 'required|max:255',
            'Ar_Commercial_name' => 'required|max:255',
            'En_Scientific_name' => 'required|max:255',
            'Ar_Scientific_name' => 'required|max:255',
            'En_Manufacture_company' => 'required',
            'Ar_Manufacture_company' => 'required',
            'Category_id' => 'required'
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


