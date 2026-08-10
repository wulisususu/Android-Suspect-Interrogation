.class Lcom/taobao/monitor/impl/trace/a$c;
.super Ljava/lang/Object;
.source "AbsDispatcher.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/trace/a$d;

.field final synthetic a:Lcom/taobao/monitor/impl/trace/a;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/trace/a;Lcom/taobao/monitor/impl/trace/a$d;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/a$c;->a:Lcom/taobao/monitor/impl/trace/a;

    iput-object p2, p0, Lcom/taobao/monitor/impl/trace/a$c;->a:Lcom/taobao/monitor/impl/trace/a$d;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/a$c;->a:Lcom/taobao/monitor/impl/trace/a;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a;)Ljava/util/List;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/monitor/impl/trace/a$c;->a:Lcom/taobao/monitor/impl/trace/a$d;

    .line 2
    invoke-interface {v2, v1}, Lcom/taobao/monitor/impl/trace/a$d;->a(Ljava/lang/Object;)V

    goto :goto_0

    :cond_0
    return-void
.end method
