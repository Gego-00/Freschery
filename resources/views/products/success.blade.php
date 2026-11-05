@extends('layouts.app')

@section('content')

<div id="page-content" class="page-content">
    <div class="banner">
        <div class="jumbotron jumbotron-bg text-center rounded-0" style="margin-top: -24px; background-image: url('{{ asset('assets/img/bg-header.jpg') }}');">
            <div class="container">
                <h1 class="pt-5">
                    Payment Successfull! Your order is on the way, thank you!
                </h1>
                <p class="btn btn-primary" href="{{ route('home') }}">
                    Back to Home.
                </p>
            </div>
        </div>
    </div>



@endsection