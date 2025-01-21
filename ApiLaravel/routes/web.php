<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\JokeController;

Route::get('/', function () {
    return view('welcome');
});


