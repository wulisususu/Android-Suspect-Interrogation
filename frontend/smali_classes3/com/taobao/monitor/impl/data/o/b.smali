.class public Lcom/taobao/monitor/impl/data/o/b;
.super Ljava/lang/Object;
.source "GCDetector.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method protected finalize()V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Throwable;
        }
    .end annotation

    .line 1
    invoke-super {p0}, Ljava/lang/Object;->finalize()V

    .line 2
    invoke-static {}, Lcom/taobao/monitor/impl/data/o/c;->a()V

    return-void
.end method
