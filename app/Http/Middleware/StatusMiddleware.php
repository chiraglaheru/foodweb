<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class StatusMiddleware
{
    public function handle(Request $request, Closure $next)
    {

        // Example: Check if the user's status is active
        if (auth()->check() && auth()->user()->status == 1) {
            return $next($request);
        }

        // Redirect or abort if the status is not active
        return redirect()->route('client.dashboard')->with('error', 'Your account is not active.');
    }
}
