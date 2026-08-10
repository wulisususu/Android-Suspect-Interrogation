.class public Landroidx/camera/camera2/internal/compat/quirk/Preview3AThreadCrashQuirk;
.super Ljava/lang/Object;
.source "Preview3AThreadCrashQuirk.java"

# interfaces
.implements Landroidx/camera/core/impl/Quirk;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 32
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static load()Z
    .locals 2

    const-string/jumbo v0, "samsungexynos7870"

    .line 35
    sget-object v1, Landroid/os/Build;->HARDWARE:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    return v0
.end method
