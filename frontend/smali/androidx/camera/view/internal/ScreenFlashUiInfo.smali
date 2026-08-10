.class public Landroidx/camera/view/internal/ScreenFlashUiInfo;
.super Ljava/lang/Object;
.source "ScreenFlashUiInfo.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;
    }
.end annotation


# instance fields
.field private final mProviderType:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

.field private final mScreenFlash:Landroidx/camera/core/ImageCapture$ScreenFlash;


# direct methods
.method public constructor <init>(Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;Landroidx/camera/core/ImageCapture$ScreenFlash;)V
    .locals 0

    .line 51
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Landroidx/camera/view/internal/ScreenFlashUiInfo;->mProviderType:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    iput-object p2, p0, Landroidx/camera/view/internal/ScreenFlashUiInfo;->mScreenFlash:Landroidx/camera/core/ImageCapture$ScreenFlash;

    return-void
.end method


# virtual methods
.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    .line 69
    :cond_0
    instance-of v1, p1, Landroidx/camera/view/internal/ScreenFlashUiInfo;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    .line 70
    :cond_1
    check-cast p1, Landroidx/camera/view/internal/ScreenFlashUiInfo;

    iget-object v1, p0, Landroidx/camera/view/internal/ScreenFlashUiInfo;->mProviderType:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    .line 71
    iget-object v3, p1, Landroidx/camera/view/internal/ScreenFlashUiInfo;->mProviderType:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    if-ne v1, v3, :cond_2

    iget-object v1, p0, Landroidx/camera/view/internal/ScreenFlashUiInfo;->mScreenFlash:Landroidx/camera/core/ImageCapture$ScreenFlash;

    iget-object p1, p1, Landroidx/camera/view/internal/ScreenFlashUiInfo;->mScreenFlash:Landroidx/camera/core/ImageCapture$ScreenFlash;

    invoke-static {v1, p1}, Ljava/util/Objects;->equals(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_2

    goto :goto_0

    :cond_2
    move v0, v2

    :goto_0
    return v0
.end method

.method public getProviderType()Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;
    .locals 1

    iget-object v0, p0, Landroidx/camera/view/internal/ScreenFlashUiInfo;->mProviderType:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    return-object v0
.end method

.method public getScreenFlash()Landroidx/camera/core/ImageCapture$ScreenFlash;
    .locals 1

    iget-object v0, p0, Landroidx/camera/view/internal/ScreenFlashUiInfo;->mScreenFlash:Landroidx/camera/core/ImageCapture$ScreenFlash;

    return-object v0
.end method

.method public hashCode()I
    .locals 2

    iget-object v0, p0, Landroidx/camera/view/internal/ScreenFlashUiInfo;->mProviderType:Landroidx/camera/view/internal/ScreenFlashUiInfo$ProviderType;

    iget-object v1, p0, Landroidx/camera/view/internal/ScreenFlashUiInfo;->mScreenFlash:Landroidx/camera/core/ImageCapture$ScreenFlash;

    .line 77
    filled-new-array {v0, v1}, [Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Ljava/util/Objects;->hash([Ljava/lang/Object;)I

    move-result v0

    return v0
.end method
