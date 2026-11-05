<?php

namespace App\Models\Product;

use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    protected $table = 'cart';

    protected $fillable = [
        "name",
        "image",
        "price",
        "qty",
        "prod_id",
        "user_id",
        "subtotal"

    ];

    public $timestamps = true;
}
