.class Lcom/taobao/monitor/impl/data/m/c$a;
.super Ljava/lang/Object;
.source "BackgroundForegroundEventImpl.java"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/monitor/impl/data/m/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/taobao/monitor/impl/data/m/c;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/data/m/c;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/data/m/c$a;->a:Lcom/taobao/monitor/impl/data/m/c;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/c$a;->a:Lcom/taobao/monitor/impl/data/m/c;

    .line 1
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/m/c;->a(Lcom/taobao/monitor/impl/data/m/c;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/taobao/monitor/impl/data/m/c$a;->a:Lcom/taobao/monitor/impl/data/m/c;

    .line 2
    invoke-static {v0}, Lcom/taobao/monitor/impl/data/m/c;->a(Lcom/taobao/monitor/impl/data/m/c;)Lcom/taobao/application/common/data/d;

    move-result-object v0

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lcom/taobao/application/common/data/d;->b(Z)V

    :cond_0
    return-void
.end method
