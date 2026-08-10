.class public Lcom/taobao/monitor/performance/DefaultApmAdapterFactory;
.super Ljava/lang/Object;
.source "DefaultApmAdapterFactory.java"

# interfaces
.implements Lcom/taobao/monitor/performance/IApmAdapterFactory;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 5
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public createApmAdapter()Lcom/taobao/monitor/performance/IWXApmAdapter;
    .locals 1

    .line 8
    new-instance v0, Lcom/taobao/monitor/performance/DefaultWXApmAdapter;

    invoke-direct {v0}, Lcom/taobao/monitor/performance/DefaultWXApmAdapter;-><init>()V

    return-object v0
.end method

.method public createApmAdapterByType(Ljava/lang/String;)Lcom/taobao/monitor/performance/IWXApmAdapter;
    .locals 0

    .line 13
    invoke-virtual {p0}, Lcom/taobao/monitor/performance/DefaultApmAdapterFactory;->createApmAdapter()Lcom/taobao/monitor/performance/IWXApmAdapter;

    move-result-object p1

    return-object p1
.end method
