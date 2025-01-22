<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Joke;

class JokeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        //
        $jokes = Joke::all();
        return response()->json([
            'status' => true,
	    'message' => 'Jokes loaded',
	    'jokes' => $jokes
        ], 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
        $jokes = Joke::create($request->all());

        return response()->json([
            'status' => true,
            'message' => 'Joke created successfully!',
            'jokes' => $jokes
        ], 200);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
        $joke = Joke::find($id);
        return response()->json([
            'joke' => $joke
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
	$jokeToUpdate = Joke::find($id);
	if($jokeToUpdate){
	    $jokeToUpdate->update($request->all());
	    return response()->json([
			'status' => true,
			'message' => 'Joke updated succesful',
			'joke' => $jokeToUpdate
			], 200);
	} else {
	   return response()->json([
			'status' => false,
			'message' => 'Joke not found'
			], 404);
	}
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
	$jokeDelete = Joke::find($id);
        if($jokeDelete){
            $jokeDelete->delete();
	    // Delete all datas
	    //Joke::where('id', '>', '1')->delete();
            return response()->json([
                'status' => true,
                'message' => 'Joke deleted successfully!'
            ], 200);
        }else{
            return response()->json([
                'status' => false,
                'message' => 'Joke not found!'
            ], 404);
        }
    }
}
