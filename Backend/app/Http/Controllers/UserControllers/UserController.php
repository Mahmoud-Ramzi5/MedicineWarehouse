<?php

namespace App\Http\Controllers\UserControllers;
use App\Http\Controllers\Controller;

use App\Http\Requests\UserRequests\LoginRequest;
use App\Http\Requests\UserRequests\RegisterRequest;
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
                'success' => false,
                'message' => 'Invalid credentials',
                'errors' => [
                    'password' => [
                        'Passwords does not match.'
                    ],
                    'confirmPassword' => [
                        'Passwords does not match.'
                    ]
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
            'success' => true,
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
                'success' => false,
                'message' => 'Invalid credentials',
                'errors' => [
                    'phoneNumber' => [
                        'Invalid phone-number or password.'
                    ],
                    'password' => [
                        'Invalid phone-number or password.'
                    ]
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
            'success' => true,
            'message' => 'Successfully logged in',
            'access_token' => $authToken,
        ], 200);
    }

    function Logout(Request $request)
    {
        // Logout User
        $request->user()->currentAccessToken()->delete();
        return response()->json([
            'success' => true,
            'message' => 'Successfully logged out',
        ], 200);
    }
}
