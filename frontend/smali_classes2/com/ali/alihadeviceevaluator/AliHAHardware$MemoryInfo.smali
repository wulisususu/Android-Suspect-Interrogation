.class public Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;
.super Ljava/lang/Object;
.source "AliHAHardware.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ali/alihadeviceevaluator/AliHAHardware;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = "MemoryInfo"
.end annotation


# instance fields
.field public dalvikPSSMemory:J

.field public deviceLevel:I

.field public deviceTotalMemory:J

.field public deviceUsedMemory:J

.field public jvmTotalMemory:J

.field public jvmUsedMemory:J

.field public nativePSSMemory:J

.field public nativeTotalMemory:J

.field public nativeUsedMemory:J

.field public runtimeLevel:I

.field final synthetic this$0:Lcom/ali/alihadeviceevaluator/AliHAHardware;

.field public totalPSSMemory:J


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

    iput-object p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->this$0:Lcom/ali/alihadeviceevaluator/AliHAHardware;

    .line 293
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 p1, -0x1

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->deviceLevel:I

    iput p1, p0, Lcom/ali/alihadeviceevaluator/AliHAHardware$MemoryInfo;->runtimeLevel:I

    return-void
.end method
