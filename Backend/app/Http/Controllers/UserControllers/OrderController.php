<?php

namespace App\Http\Controllers\UserControllers;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use App\Models\Medicine;
use App\Models\Order;
use App\Models\OrderedMedicine;
use Laravel\Sanctum\PersonalAccessToken;

function DoNothing() {;}

class OrderController extends Controller
{
    public function ShowOrders(Request $request)
    {
        $hashedToken =$request->bearerToken();
        $token = PersonalAccessToken::where('token', $hashedToken)->first();
        $user = $token->tokenable;
        // Get user id
        $id = $user->id;
        // User Orders
        $orders = Order::where('user_id', $id)->get();
        if ($orders->isEmpty()) {
            return response()->json([
                'message' => 'Invalid User'
            ], 400);
        }
        foreach ($orders as $order) {
            $order->OrderedMedicines;
            $medicines = $order->Medicines;
            foreach($medicines as $medicine) {
                $medicine->MedicineTranslations;
                $medicine->Categories;
            }
        }
        return response()->json([
            'data' => $orders
        ], 200)->header('Content-Type', 'application/json; charset=UTF-8');
    }

    public function Add_Order(Request $request)
    {
        // Validate request
        $validated = $request->validate([
            'user_id' => 'required',
            'medicines' => 'required'
        ]);
        // Check medicines and quantities
        $medicines = [];
        foreach ($validated['medicines'] as $index => $value) {
            array_push($medicines, $index);
            $medicine = Medicine::find($index);
            if ($medicine == null) {
                return response()->json([
                    'message' => 'Invalid Medicine'
                ], 400);
            }
            $quantity = $medicine->quantity_available;
            if ($quantity < $value) {
                return response()->json([
                    'message' => 'Quantity not available'
                ], 400);
            }
        }
        // Create order
        $order = Order::create([
            'user_id' => $validated['user_id'],
            'status' => 'PREPARING',
            'is_paid' => false
        ]);
        $order->Medicines()->attach($medicines);
        // Set new values
        foreach ($validated['medicines'] as $index => $value) {
            $ordered_medicine = OrderedMedicine::create([
                'order_id' => $order->id,
                'medicine_id' => $index,
                'quantity'=> $value
            ]);
            $medicine = Medicine::find($index);
            $quantity = $medicine->quantity_available;
            $reserved = $medicine->quantity_allocated;
            $medicine->quantity_available = $quantity - $value;
            $medicine->quantity_allocated = $reserved + $value;
            $medicine->save();
        }
        // Response
        return response()->json([
            'message' => 'Successfully ordered'
        ], 200);
    }
}
