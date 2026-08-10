.class public final Landroidx/camera/core/internal/compat/MediaActionSoundCompat;
.super Ljava/lang/Object;
.source "MediaActionSoundCompat.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 59
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static mustPlayShutterSound()Z
    .locals 2

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v1, 0x21

    if-lt v0, v1, :cond_0

    .line 52
    invoke-static {}, Landroidx/camera/core/internal/compat/MediaActionSoundCompatApi33Impl;->mustPlayShutterSound()Z

    move-result v0

    return v0

    .line 54
    :cond_0
    invoke-static {}, Landroidx/camera/core/internal/compat/MediaActionSoundCompatBaseImpl;->mustPlayShutterSound()Z

    move-result v0

    return v0
.end method
