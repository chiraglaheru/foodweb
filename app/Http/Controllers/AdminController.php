<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use App\Mail\Websitemail;
use App\Models\Admin;

class AdminController extends Controller
{
    // Admin login page
    public function AdminLogin()
    {
        return view('admin.login');
    }

    // Admin dashboard
    public function AdminDashboard()
    {
        return view('admin.admin_dashboard');
    }

    // Forgot Password Form (GET)
    public function AdminForgotPasswordForm()
    {
        return view('admin.forgot_password');
    }

    // Handle Forgot Password Form Submission (POST)
    public function AdminForgotPassword(Request $request)
    {
        $request->validate(['email'=> 'required|email']);

        $admin = Admin::where('email', $request->email)->first();
        if (!$admin) {
            return redirect()->back()->with('error', 'Email not found');
        }

        // Generate a secure token for password reset
        $token = Str::random(60);
        $admin->token = $token;
        $admin->save();

        // Logic for sending a password reset link
        $resetLink = route('admin.reset_password', ['token' => $token, 'email' => urlencode($request->email)]); // URL encode the email
        \Mail::to($admin->email)->send(new Websitemail('Password Reset', "Click here to reset your password: $resetLink"));

        return back()->with('success', 'Password reset link has been sent to your email.');
    }

    // Password Submission (Handle Reset Logic)
    public function AdminPasswordSubmit(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
        ]);

        $admin_data = Admin::where('email', $request->email)->first();
        if ($admin_data) {
            // Generate a secure token for password reset
            $token = Str::random(60);

            // Save the token to the admin record
            $admin_data->token = $token;
            $admin_data->save();

            // Generate the reset link
            $reset_link = url('admin/reset-password/' . $token . '/' . urlencode($request->email));
            $subject = "Reset password";
            $message = "Please click on the link below to reset your password:<br>";
            $message .= "<a href='" . $reset_link . "'>Click here</a>";

            // Send the reset link via email
            \Mail::to($request->email)->send(new Websitemail($subject, $message));

            return redirect()->back()->with('success', 'Reset password link has been sent to your email.');
        } else {
            return redirect()->back()->with('error', 'Email not found.');
        }
    }

    // Handle Admin Login Form Submission
    public function AdminLoginSubmit(Request $request)
    {
        // Validate email and password fields
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        // Attempt to log the admin in
        $credentials = $request->only('email', 'password');

        if (Auth::guard('admin')->attempt($credentials)) {
            return redirect()->route('admin.dashboard')->with('success', 'Login Successful');
        } else {
            return redirect()->route('admin.login')->with('error', 'Invalid Email or Password');
        }
    }

    // Admin logout
    public function AdminLogout()
    {
        Auth::guard('admin')->logout();
        session()->invalidate();  // Invalidate the session
        session()->regenerateToken();  // Regenerate CSRF token after logout

        return redirect()->route('admin.login')->with('success', 'Logged out successfully');
    }

    // Reset Password form
    public function AdminResetPassword($token, $email)
    {
        $admin_data = Admin::where('email', $email)->where('token', $token)->first();

        if (!$admin_data) {
            return redirect()->route('admin.login')->with('error', 'Invalid token or email');
        }

        return view('admin.reset_password', compact('token', 'email'));
    }

    // Handle Reset Password Form Submission
    public function AdminPasswordReset(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|confirmed|min:8',
            'token' => 'required',
        ]);

        // Find the admin user based on the email and token
        $admin = Admin::where('email', $request->email)->where('token', $request->token)->first();

        if (!$admin) {
            return redirect()->route('admin.login')->with('error', 'Invalid token or email');
        }

        // Update the password
        $admin->password = Hash::make($request->password);
        $admin->token = null; // Clear the token after password reset
        $admin->save();

        return redirect()->route('admin.login')->with('success', 'Password successfully updated!');
    }

    public function AdminProfile(){
        $id = Auth::guard('admin')->id();
        $profileData = Admin::find($id);
        return view('admin.admin_profile', compact('profileData'));
    }

    public function AdminProfileStore(Request $request){
        $id = Auth::guard('admin')->id();
        $data = Admin::find($id);
        $data->name = $request->name;
        $data->email = $request->email;
        $data->phone = $request->phone;
        $data->address = $request->address;

        $oldPhotoPath = $data->photo;

        if ($request->hasfile('photo')) {
            $file = $request->file('photo');
            $filename = time().'.'.$file->getClientOriginalExtension();
            $file->move(public_path('upload/admin_images'), $filename);
            $data->photo = $filename;
        }
        
        // Use the old photo path if no new photo is uploaded
        $filename = $oldPhotoPath;

        if ($oldPhotoPath && $oldPhotoPath !== $filename) {
            $this->deleteOldImage($oldPhotoPath);
        }

        $data->save();

        $notification = [
            'message' => 'Profile Updated Successfully',
            'alert-type' => 'success',
        ];
        return redirect()->back()->with($notification);
    }

    private function deleteOldImage(string $oldPhotoPath): void {
        $fullpath = public_path('upload/admin_images/'.$oldPhotoPath);
        if (file_exists($fullpath)) {
            unlink($fullpath);
        }
    }

    public function AdminChangePassword() {
        $id = Auth::guard('admin')->id();
        $profileData = Admin::find($id);
        return view('admin.admin_change_Password', compact('profileData'));
    }

    public function AdminPasswordUpdate(Request $request) {
        $admin = Auth::guard('admin')->user();
        
        // Corrected validation
        $request->validate([
            'old_password' => 'required',
            'new_password' => 'required|confirmed',
        ]);

        // Check if the old password matches the current password
        if (!Hash::check($request->old_password, $admin->password)) {
            $notification = [
                'message' => 'Old Password Does Not Match',
                'alert-type' => 'error'
            ];
            return back()->with($notification);
        }

        // Update the new password
        Admin::whereId($admin->id)->update([
            'password' => Hash::make($request->new_password)
        ]);

        // Success notification
        $notification = [
            'message' => 'Password Changed Successfully',
            'alert-type' => 'success'
        ];

        return back()->with($notification);
    }
}
