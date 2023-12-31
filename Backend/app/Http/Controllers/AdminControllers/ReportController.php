<?php

namespace App\Http\Controllers\AdminControllers;
use App\Http\Controllers\Controller;

use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\Models\Medicine;
use App\Enums\OrderEnum;
use App\Models\Order;

class ReportController extends Controller
{
    public function Show(Request $request)
    {

        $validated = $request->validate([
            'start_date' => 'required',
            'end_date' => 'required'
        ]);
        $medicines_count = collect();
        $order_count = 0;
        $income = 0.0;

        // All Orders
        $orders = Order::with('User')->whereDate('created_at', '>=', $validated['start_date'])
                                        ->whereDate('created_at', '<=', $validated['end_date'])->get();

        // Response
        return response()->json([
            'message' => [
                'income' => $income,
                'order_count' => $order_count,
            ]
        ],200);
    }
}
