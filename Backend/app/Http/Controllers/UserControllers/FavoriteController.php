<?php

namespace App\Http\Controllers\UserControllers;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use App\Models\Medicine;
use App\Models\Favorite;

class FavoriteController extends Controller
{
    //Displaying The Favorite Medicines
    public function DisplayFavorite(Request $request){
        $user =  auth('sanctum')->user();
        if ($user == null) {
            return response()->json([
                'message' => 'Invalid User'
            ], 400);
        }
        // Get user id
        $user_id = $user->id;
        $favorite = Favorite::where('user_id', $user_id)->first();
        $medicines = $favorite->Medicines;
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
        return response()->json(['message' => $favorite]);
    }

    //Adding The Medicine To Favorite
    public function AddToFavorite(Request $request)
    {
        // Validate request
        $validated = $request->validate([
            'medicine_id' => 'required'
        ]);
        $user = auth('sanctum')->user();
        if ($user == null) {
            return response()->json([
                'message' => 'Invalid User'
            ], 400);
        }
        // Get user Favorite
        $favorite = Favorite::where('user_id', $user->id)->first();
        // Check medicines
        $medicine_id = $validated['medicine_id'];
        $medicine = Medicine::find($medicine_id);
        if ($medicine == null) {
            return response()->json([
                'message' => 'Invalid Medicine'
            ], 400);
        }
        $medicines = $favorite->Medicines;
        foreach($medicines as $medicine1) {
            if($medicine['id'] == $medicine1['id']){
                return response()->json([
                    'message' => 'Medicine Already In Favorites'
                ], 200);
            }
        }
        $favorite->Medicines()->attach($medicine);
        return response()->json([
            'message' => 'Successfully Added To Favorite'
        ], 200);
    }

    //Removing The Medicine From Favorites
    public function DeleteFavorite(Request $request)
    {
        // Validate request
        $validated = $request->validate([
            'medicine_id' => 'required'
        ]);
        $user = auth('sanctum')->user();
        if ($user == null) {
            return response()->json([
                'message' => 'Invalid User'
            ], 400);
        }
        // Get user Favorite
        $favorite = Favorite::where('user_id', $user->id)->first();
        // Check medicines
        $medicine_id = $validated['medicine_id'];
        $medicine = Medicine::find($medicine_id);
        if ($medicine == null) {
            return response()->json([
                'message' => 'Invalid Medicine'
            ], 400);
        }
        $favorite->Medicines()->detach($medicine);
        // Response
        return response()->json([
            'message' => 'Successfully Removed From Favorite'
        ], 200);
    }

}
