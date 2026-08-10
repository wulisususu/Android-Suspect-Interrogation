.class public Lcom/taobao/monitor/impl/data/o/a;
.super Ljava/lang/Object;
.source "GCCollector.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 2

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/data/o/d;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/data/o/d;-><init>()V

    const-string v1, "APPLICATION_GC_DISPATCHER"

    .line 2
    invoke-static {v1}, Lcom/taobao/monitor/impl/trace/g;->a(Ljava/lang/String;)Lcom/taobao/monitor/impl/trace/IDispatcher;

    move-result-object v1

    .line 3
    invoke-interface {v1, v0}, Lcom/taobao/monitor/impl/trace/IDispatcher;->addListener(Ljava/lang/Object;)V

    .line 4
    invoke-virtual {v0}, Lcom/taobao/monitor/impl/data/o/d;->d()V

    return-void
.end method
