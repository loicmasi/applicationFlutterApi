<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\JokeController;

// Route::get('/user', function (Request $request) {
//     return $request->user();
// })->middleware('auth:sanctum');

// API
Route::get('/jokes', [JokeController::class, 'index']);
Route::get('/jokes/{id}', [JokeController::class, 'show']);
Route::post('/jokes', [JokeController::class, 'store']);