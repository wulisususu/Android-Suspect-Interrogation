.class public Lcom/taobao/monitor/impl/processor/b/a;
.super Ljava/lang/Object;
.source "WeexApmAdapterFactory.java"

# interfaces
.implements Lcom/taobao/monitor/performance/IApmAdapterFactory;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/monitor/impl/processor/b/a$b;
    }
.end annotation


# instance fields
.field private a:Lcom/taobao/monitor/performance/IWXApmAdapter;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$a;

    invoke-direct {v0, p0}, Lcom/taobao/monitor/impl/processor/b/a$a;-><init>(Lcom/taobao/monitor/impl/processor/b/a;)V

    iput-object v0, p0, Lcom/taobao/monitor/impl/processor/b/a;->a:Lcom/taobao/monitor/performance/IWXApmAdapter;

    return-void
.end method


# virtual methods
.method public createApmAdapter()Lcom/taobao/monitor/performance/IWXApmAdapter;
    .locals 1

    const-string v0, "weex_page"

    .line 1
    invoke-virtual {p0, v0}, Lcom/taobao/monitor/impl/processor/b/a;->createApmAdapterByType(Ljava/lang/String;)Lcom/taobao/monitor/performance/IWXApmAdapter;

    move-result-object v0

    return-object v0
.end method

.method public createApmAdapterByType(Ljava/lang/String;)Lcom/taobao/monitor/performance/IWXApmAdapter;
    .locals 2

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/processor/b/a$b;

    sget-boolean v1, Lcom/taobao/monitor/impl/common/DynamicConstants;->needWeex:Z

    if-eqz v1, :cond_0

    new-instance v1, Lcom/taobao/monitor/impl/processor/b/b;

    invoke-direct {v1, p1}, Lcom/taobao/monitor/impl/processor/b/b;-><init>(Ljava/lang/String;)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/b/a;->a:Lcom/taobao/monitor/performance/IWXApmAdapter;

    :goto_0
    const/4 p1, 0x0

    invoke-direct {v0, v1, p1}, Lcom/taobao/monitor/impl/processor/b/a$b;-><init>(Lcom/taobao/monitor/performance/IWXApmAdapter;Lcom/taobao/monitor/impl/processor/b/a$a;)V

    return-object v0
.end method
