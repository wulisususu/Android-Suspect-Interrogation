.class public final Landroidx/camera/camera2/internal/compat/quirk/YuvImageOnePixelShiftQuirk;
.super Ljava/lang/Object;
.source "YuvImageOnePixelShiftQuirk.java"

# interfaces
.implements Landroidx/camera/core/internal/compat/quirk/OnePixelShiftQuirk;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static isMotorolaMotoG3()Z
    .locals 2

    const-string v0, "motorola"

    .line 41
    sget-object v1, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "MotoG3"

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private static isSamsungSMA920F()Z
    .locals 2

    const-string/jumbo v0, "samsung"

    .line 57
    sget-object v1, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "SM-A920F"

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private static isSamsungSMG532F()Z
    .locals 2

    const-string/jumbo v0, "samsung"

    .line 45
    sget-object v1, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "SM-G532F"

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private static isSamsungSMJ415F()Z
    .locals 2

    const-string/jumbo v0, "samsung"

    .line 53
    sget-object v1, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "SM-J415F"

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private static isSamsungSMJ700F()Z
    .locals 2

    const-string/jumbo v0, "samsung"

    .line 49
    sget-object v1, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "SM-J700F"

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private static isXiaomiMiA1()Z
    .locals 2

    const-string/jumbo v0, "xiaomi"

    .line 61
    sget-object v1, Landroid/os/Build;->BRAND:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "Mi A1"

    sget-object v1, Landroid/os/Build;->MODEL:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method static load(Landroidx/camera/camera2/internal/compat/CameraCharacteristicsCompat;)Z
    .locals 0

    .line 36
    invoke-static {}, Landroidx/camera/camera2/internal/compat/quirk/YuvImageOnePixelShiftQuirk;->isMotorolaMotoG3()Z

    move-result p0

    if-nez p0, :cond_1

    invoke-static {}, Landroidx/camera/camera2/internal/compat/quirk/YuvImageOnePixelShiftQuirk;->isSamsungSMG532F()Z

    move-result p0

    if-nez p0, :cond_1

    invoke-static {}, Landroidx/camera/camera2/internal/compat/quirk/YuvImageOnePixelShiftQuirk;->isSamsungSMJ700F()Z

    move-result p0

    if-nez p0, :cond_1

    .line 37
    invoke-static {}, Landroidx/camera/camera2/internal/compat/quirk/YuvImageOnePixelShiftQuirk;->isSamsungSMA920F()Z

    move-result p0

    if-nez p0, :cond_1

    invoke-static {}, Landroidx/camera/camera2/internal/compat/quirk/YuvImageOnePixelShiftQuirk;->isSamsungSMJ415F()Z

    move-result p0

    if-nez p0, :cond_1

    invoke-static {}, Landroidx/camera/camera2/internal/compat/quirk/YuvImageOnePixelShiftQuirk;->isXiaomiMiA1()Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    goto :goto_1

    :cond_1
    :goto_0
    const/4 p0, 0x1

    :goto_1
    return p0
.end method
