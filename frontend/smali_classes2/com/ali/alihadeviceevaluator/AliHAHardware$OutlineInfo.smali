.class public Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;
.super Ljava/lang/Object;
.source "AliHAHardware.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ali/alihadeviceevaluator/AliHAHardware;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "OutlineInfo"
.end annotation


# instance fields
.field public deviceLevel:I

.field public deviceLevelEasy:I

.field public deviceScore:I

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

    iput-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->this$0:Lcom/ali/alihadeviceevaluator/AliHAHardware;

    .line 305
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, -0x1

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->deviceLevel:I

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->runtimeLevel:I

    return-void
.end method


# virtual methods
.method public update()Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;
    .locals 4

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->this$0:Lcom/ali/alihadeviceevaluator/AliHAHardware;

    .line 311
    invoke-virtual {v0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getCpuInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->this$0:Lcom/ali/alihadeviceevaluator/AliHAHardware;

    .line 312
    invoke-virtual {v0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->getDisplayInfo()Lcom/ali/alihadeviceevaluator/AliHAHardware$DisplayInfo;

    iget-object v0, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->this$0:Lcom/ali/alihadeviceevaluator/AliHAHardware;

    .line 313
    invoke-static {v0}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->access$200(Lcom/ali/alihadeviceevaluator/AliHAHardware;)Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;

    move-result-object v0

    iget-object v1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->this$0:Lcom/ali/alihadeviceevaluator/AliHAHardware;

    invoke-static {v1}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->access$300(Lcom/ali/alihadeviceevaluator/AliHAHardware;)Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;

    move-result-object v1

    iget v1, v1, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->runtimeLevel:I

    int-to-float v1, v1

    const v2, 0x3f4ccccd    # 0.8f

    mul-float/2addr v1, v2

    iget-object v2, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->this$0:Lcom/ali/alihadeviceevaluator/AliHAHardware;

    invoke-static {v2}, Lcom/ali/alihadeviceevaluator/AliHAHardware;->access$400(Lcom/ali/alihadeviceevaluator/AliHAHardware;)Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;

    move-result-object v2

    iget v2, v2, Lcom/ali/alihadeviceevaluator/AliHAHardware$CPUInfo;->runtimeLevel:I

    int-to-float v2, v2

    const v3, 0x3f99999a    # 1.2f

    mul-float/2addr v2, v3

    add-float/2addr v1, v2

    const/high16 v2, 0x40000000    # 2.0f

    div-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    move-result v1

    iput v1, v0, Lcom/ali/alihadeviceevaluator/AliHAHardware$OutlineInfo;->runtimeLevel:I

    return-object p0
.end method
