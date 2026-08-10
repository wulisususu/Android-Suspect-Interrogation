.class Lcom/taobao/monitor/impl/processor/b/a$b$e;
.super Ljava/lang/Object;
.source "WeexApmAdapterFactory.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/processor/b/a$b;->onEvent(Ljava/lang/String;Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/processor/b/a$b;

.field final synthetic a:Ljava/lang/Object;

.field final synthetic a:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/processor/b/a$b;Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/processor/b/a$b$e;->a:Lcom/taobao/monitor/impl/processor/b/a$b;

    iput-object p2, p0, Lcom/taobao/monitor/impl/processor/b/a$b$e;->a:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/monitor/impl/processor/b/a$b$e;->a:Ljava/lang/Object;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/processor/b/a$b$e;->a:Lcom/taobao/monitor/impl/processor/b/a$b;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/processor/b/a$b;->a(Lcom/taobao/monitor/impl/processor/b/a$b;)Lcom/taobao/monitor/performance/IWXApmAdapter;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/processor/b/a$b$e;->a:Ljava/lang/String;

    iget-object v2, p0, Lcom/taobao/monitor/impl/processor/b/a$b$e;->a:Ljava/lang/Object;

    invoke-interface {v0, v1, v2}, Lcom/taobao/monitor/performance/IWXApmAdapter;->onEvent(Ljava/lang/String;Ljava/lang/Object;)V

    return-void
.end method
