<?php

namespace App\Http\Controllers\UserControllers;
use App\Http\Controllers\MedicinesController;

use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\Medicine;
use App\Models\Category;
use App\Models\Favorite;
use App\Models\MedicineTranslation;

class UserMedicinesController extends MedicinesController
{
    public function ShowNotExpired(Request $request)
    {
        $user = auth('sanctum')->user();
        if ($user==null) {
            return response()->json([
                'message' => 'Invalid User'
            ], 400);
        }
        // Get user Favorite
        $favorite = Favorite::where('user_id', $user->id)->first();
        // Get Today's Date
        $Date = today();
        // Fetch medicines from database
        $medicines = Medicine::whereDate('expiry_date', '>=', "$Date")
                                ->where('quantity_available', '>', 0)
                                ->with('MedicineTranslations')
                                ->with('Categories')->get();
        foreach ($medicines as $medicine) {
            if ($favorite->Medicines()->where('medicine_id', '=', $medicine->id)->exists()) {
                $medicine['is_favorite'] = true;
            }
            else {
                $medicine['is_favorite'] = false;
            }
        }
        // Not Expired Medicines
        return response()->json([
            'data' => $medicines
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }

    public function Selected_Category(Request $request)
    {
        $user = auth('sanctum')->user();
        if ($user==null) {
            return response()->json([
                'message' => 'Invalid User'
            ], 400);
        }
        // Get user Favorite
        $favorite = Favorite::where('user_id', $user->id)->first();
        // Get Category's Id
        $id = $request->input('id');
        // Find the selected category
        $category = Category::find($id);
        if ($category == null) {
            return response()->json([
                'message' => 'Invalid Category'
            ], 400);
        }
        // Get Today's Date
        $Date = today();
        // Find the medicines with the selected category
        $medicines = $category->Medicines()->whereDate('expiry_date', '>=', "$Date")->get();
        foreach($medicines as $medicine) {
            $medicine->MedicineTranslations;
            $medicine->Categories;
            if ($favorite->Medicines()->where('medicine_id', '=', $medicine->id)->exists()) {
                $medicine['is_favorite'] = true;
            }
            else {
                $medicine['is_favorite'] = false;
            }
        }
        // Not Expired Medicines
        return response()->json([
            'message' => $medicines
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }

    function Search_Not_Expired(Request $request)
    {
        $user = auth('sanctum')->user();
        if ($user==null) {
            return response()->json([
                'message' => 'Invalid User'
            ], 400);
        }
        // Get user Favorite
        $favorite = Favorite::where('user_id', $user->id)->first();
        // Get Today's Date
        $Date = today();
        // Search Input
        $input = $request->input('name');
        // Fetch medicines from database
        $query = MedicineTranslation::where('commercial_name', 'like', "%$input%")
                                        ->orWhere('scientific_name', 'like', "%$input%")->get();
        $medicines = [];
        foreach ($query as $q) {
            $id = $q->medicine_id;
            $medicine = Medicine::where([['id', '=', $id],
                                        ['expiry_date', '>=', "$Date"],
                                        ['quantity_available', '>', 0]])->first();
            if ($medicine != null) {
                $medicine->MedicineTranslations;
                $medicine->Categories;
                if ($favorite->Medicines()->where('medicine_id', '=', $medicine->id)->exists()) {
                    $medicine['is_favorite'] = true;
                }
                else {
                    $medicine['is_favorite'] = false;
                }
                array_push($medicines, $medicine);
            }
        }
        // Search Response
        if ($medicines != null) {
            return response()->json([
                "message" => $medicines
            ], 200);
        }
        else {
            return response()->json([
                "message" => "No Medicines Found"
            ], 400);
        }
    }
}

