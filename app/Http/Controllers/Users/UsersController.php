<?php

namespace App\Http\Controllers\Users;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Product\Order;
use Auth;

class UsersController extends Controller
{
    public function myOrders() {

        $orders  = Order::select()->where('user_id', Auth::id())->get();
        return view('users.orders', compact('orders'));
    }
}
