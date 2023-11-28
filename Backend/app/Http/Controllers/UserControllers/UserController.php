<?php

namespace App\Http\Controllers\UserControllers;
use App\Http\Controllers\Controller;

use App\Http\Requests\UserRequests\LoginRequest;
use App\Http\Requests\UserRequests\RegisterRequest;
use App\Models\Medicine;
use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    function register(RegisterRequest $request)
    {
        // Validate Input
        $credentials = $request->validated();
        if ($credentials['password'] != $credentials['confirmPassword']) {
            return response()->json([
                'message' => 'Invalid credentials',
                'errors' => [
                    'password & confirmPassword' => [
                        'Passwords does not match.'
                    ],
                ]
            ], 400);
        }
        // Create and Register User
        $user = User::create([
            'pharmacyName' => $credentials['pharmacyName'],
            'pharmacyAddress' => $credentials['pharmacyAddress'],
            'phoneNumber' => $credentials['phoneNumber'],
            'email' => $credentials['email'],
            'password' => Hash::make($credentials['password']),
        ]);

        return response()->json([
            'message' => 'Successfully registered',
        ], 200);
    }

    function login(LoginRequest $request)
    {
        // Validate Input
        $credentials = $request->validated();
        $user = User::where('phoneNumber', $credentials['phoneNumber'])->first();
        if (! $user || ! Hash::check($credentials['password'], $user->password)) {
            return response()->json([
                'message' => 'Invalid credentials',
                'errors' => [
                    'phoneNumber & password' => [
                        'Invalid phone-number or password.'
                    ],
                ]
            ], 400);
        }
        // Handle Remember Me functionality
        if ($request->input("rememberMe")) {
            $authToken = $user->createToken(name:'auth-token', expiresAt:null)->plainTextToken;
        }
        else {
            $authToken = $user->createToken(name:'auth-token', expiresAt:now()->addHours(3))->plainTextToken;
        }
        // Login User
        return response()->json([
            'message' => 'Successfully logged in',
            'access_token' => $authToken,
        ], 200);
    }
    function Logout(Request $request)
    {
        // Logout User
        $request->user()->currentAccessToken()->delete();
        return response()->json([
            'message' => 'Successfully logged out',
        ], 200);
    }
}
