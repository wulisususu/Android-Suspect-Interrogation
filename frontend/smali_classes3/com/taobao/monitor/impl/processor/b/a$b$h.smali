.class Lcom/taobao/monitor/impl/processor/b/a$b$h;
.super Ljava/lang/Object;
.source "WeexApmAdapterFactory.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/processor/b/a$b;->addStatistic(Ljava/lang/String;D)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:D

.field final synthetic a:Lcom/taobao/monitor/impl/processor/b/a$b;

.field final synthetic a:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/processor/b/a$b;Ljava/lang/String;D)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/b/a$b$h;->a:Lcom/taobao/monitor/impl/processor/b/a$b;

    iput-object p2, p0, Lcom/taobao/monitor/impl/processor/b/a$b$h;->a:Ljava/lang/String;

    iput-wide p3, p0, Lcom/taobao/monitor/impl/processor/b/a$b$h;->a:D

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/a$b$h;->a:Lcom/taobao/monitor/impl/processor/b/a$b;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Lcom/taobao/monitor/impl/processor/b/a$b;)Lcom/taobao/monitor/performance/IWXApmAdapter;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/b/a$b$h;->a:Ljava/lang/String;

    iget-wide v2, p0, Lcom/taobao/monitor/impl/processor/b/a$b$h;->a:D

    invoke-interface {v0, v1, v2, v3}, Lcom/taobao/monitor/performance/IWXApmAdapter;->addStatistic(Ljava/lang/String;D)V

    return-void
.end method
