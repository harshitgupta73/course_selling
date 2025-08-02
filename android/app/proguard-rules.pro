# Fix for Razorpay missing annotations
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

# Keep Razorpay SDK
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**
