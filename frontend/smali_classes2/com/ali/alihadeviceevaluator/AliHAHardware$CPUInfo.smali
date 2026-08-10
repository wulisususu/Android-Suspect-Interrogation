.class public Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;
.super Ljava/lang/Object;
.source "AliHAHardware.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ali/alihadeviceevaluator/AliHAHardware;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "CPUInfo"
.end annotation


# instance fields
.field public avgFreq:F

.field public cpuCoreNum:I

.field public cpuDeivceScore:I

.field public cpuUsageOfApp:F

.field public cpuUsageOfDevcie:F

.field public deviceLevel:I

.field public runtimeLevel:I

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

    iput-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->this$0:Lcom/ali/alihadeviceevaluator/AliHAHardware;

    .line 265
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, 0x0

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->cpuCoreNum:I

    const/4 p1, 0x0

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->avgFreq:F

    const/high16 p1, -0x40800000    # -1.0f

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->cpuUsageOfApp:F

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->cpuUsageOfDevcie:F

    const/4 p1, -0x1

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->cpuDeivceScore:I

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->deviceLevel:I

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->runtimeLevel:I

    return-void
.end method
