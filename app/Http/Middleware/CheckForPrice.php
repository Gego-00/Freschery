<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Session;
class CheckForPrice
{
    /**
     * Handle an incoming request.
     *
     * @param  Closure(Request): (Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        if($request->url('products/checkout') OR $request->url('products/pay')
         OR $request->url('products/success')) {
            if(Session::get('value') == 0) {
                return abort('403');
            } 
        }

        return $next($request);
    }
}
