.class public Lcom/taobao/accs/ut/monitor/AssembleMonitor;
.super Lcom/taobao/accs/utl/BaseMonitor;
.source "Taobao"


# annotations
.annotation runtime Lanet/channel/statist/Monitor;
    module = "accs"
    monitorPoint = "assemble"
.end annotation


# instance fields
.field public assembleLength:J
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public assembleTimes:J
    .annotation runtime Lanet/channel/statist/Measure;
    .end annotation
.end field

.field public dataId:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field

.field public errorCode:Ljava/lang/String;
    .annotation runtime Lanet/channel/statist/Dimension;
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    .line 21
    invoke-direct {p0}, Lcom/taobao/accs/utl/BaseMonitor;-><init>()V

    iput-object p1, p0, Lcom/taobao/accs/ut/monitor/AssembleMonitor;->dataId:Ljava/lang/String;

    iput-object p2, p0, Lcom/taobao/accs/ut/monitor/AssembleMonitor;->errorCode:Ljava/lang/String;

    return-void
.end method
