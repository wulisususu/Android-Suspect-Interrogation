.class public Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;
.super Ljava/lang/Object;
.source "AliHAHardware.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ali/alihadeviceevaluator/AliHAHardware;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "DisplayInfo"
.end annotation


# instance fields
.field public mDensity:F

.field public mHeightPixels:I

.field public mOpenGLDeviceLevel:I

.field public mOpenGLVersion:Ljava/lang/String;

.field public mWidthPixels:I

.field final synthetic this$0:Lcom/ali/alihadeviceevaluator/AliHAHardware;


# direct methods
.method public constructor <init>(Lcom/ali/alihadeviceevaluator/AliHAHardware;)V
    .locals 0
    .annotation system Ldalvik/annotation/MethodParameters;
        accessFlags = {
            0x8010
        }
        names = {
            "this$0"
        }
    .end annotation

    iput-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->this$0:Lcom/ali/alihadeviceevaluator/AliHAHardware;

    .line 247
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->mDensity:F

    const/4 p1, 0x0

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->mWidthPixels:I

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->mHeightPixels:I

    const-string p1, "0"

    iput-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->mOpenGLVersion:Ljava/lang/String;

    const/4 p1, -0x1

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;->mOpenGLDeviceLevel:I

    return-void
.end method
