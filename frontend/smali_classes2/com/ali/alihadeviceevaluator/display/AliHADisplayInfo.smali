.class public Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;
.super Ljava/lang/Object;
.source "AliHADisplayInfo.java"


# static fields
.field private static mDisplayInfo:Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;


# instance fields
.field public mDensity:F

.field public mHeightPixels:I

.field public mWidthPixels:I


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getDisplayInfo(Landroid/content/Context;)Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;
    .locals 2
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x0
        }
        names = {
            "context"
        }
    .end annotation

    if-nez p0, :cond_0

    const/4 p0, 0x0

    return-object p0

    :cond_0
    sget-object v0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;

    if-eqz v0, :cond_1

    return-object v0

    .line 13
    :cond_1
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object p0

    invoke-virtual {p0}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p0

    .line 14
    new-instance v0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;

    invoke-direct {v0}, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;-><init>()V

    sput-object v0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;

    .line 15
    iget v1, p0, Landroid/util/DisplayMetrics;->density:F

    iput v1, v0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->mDensity:F

    sget-object v0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;

    .line 16
    iget v1, p0, Landroid/util/DisplayMetrics;->heightPixels:I

    iput v1, v0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->mHeightPixels:I

    sget-object v0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;

    .line 17
    iget p0, p0, Landroid/util/DisplayMetrics;->widthPixels:I

    iput p0, v0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->mWidthPixels:I

    sget-object p0, Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;->mDisplayInfo:Lcom/ali/alihadeviceevaluator/display/AliHADisplayInfo;

    return-object p0
.end method
