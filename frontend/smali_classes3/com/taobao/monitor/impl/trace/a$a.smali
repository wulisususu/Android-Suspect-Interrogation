.class Lcom/taobao/monitor/impl/trace/a$a;
.super Ljava/lang/Object;
.source "AbsDispatcher.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/trace/a;->addListener(Ljava/lang/Object;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/trace/a;

.field final synthetic a:Ljava/lang/Object;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/trace/a;Ljava/lang/Object;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/a$a;->a:Lcom/taobao/monitor/impl/trace/a;

    iput-object p2, p0, Lcom/taobao/monitor/impl/trace/a$a;->a:Ljava/lang/Object;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/a$a;->a:Lcom/taobao/monitor/impl/trace/a;

    iget-object v1, p0, Lcom/taobao/monitor/impl/trace/a$a;->a:Ljava/lang/Object;

    .line 1
    invoke-static {v0, v1}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/a$a;->a:Lcom/taobao/monitor/impl/trace/a;

    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a;)Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/trace/a$a;->a:Ljava/lang/Object;

    invoke-interface {v0, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/a$a;->a:Lcom/taobao/monitor/impl/trace/a;

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a;)Ljava/util/List;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/monitor/impl/trace/a$a;->a:Ljava/lang/Object;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    :cond_0
    return-void
.end method
