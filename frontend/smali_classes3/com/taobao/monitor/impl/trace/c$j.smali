.class Lcom/taobao/monitor/impl/trace/c$j;
.super Ljava/lang/Object;
.source "ActivityLifeCycleDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/a$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/trace/c;->c(Landroid/app/Activity;Landroid/os/Bundle;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/monitor/impl/trace/a$d<",
        "Lcom/taobao/monitor/impl/trace/c$s;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic a:Landroid/app/Activity;

.field final synthetic a:Landroid/os/Bundle;

.field final synthetic a:Lcom/taobao/monitor/impl/trace/c;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/trace/c;Landroid/app/Activity;Landroid/os/Bundle;J)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/c$j;->a:Lcom/taobao/monitor/impl/trace/c;

    iput-object p2, p0, Lcom/taobao/monitor/impl/trace/c$j;->a:Landroid/app/Activity;

    iput-object p3, p0, Lcom/taobao/monitor/impl/trace/c$j;->a:Landroid/os/Bundle;

    iput-wide p4, p0, Lcom/taobao/monitor/impl/trace/c$j;->a:J

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/monitor/impl/trace/c$s;)V
    .locals 4

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/c$j;->a:Landroid/app/Activity;

    iget-object v1, p0, Lcom/taobao/monitor/impl/trace/c$j;->a:Landroid/os/Bundle;

    iget-wide v2, p0, Lcom/taobao/monitor/impl/trace/c$j;->a:J

    .line 2
    invoke-interface {p1, v0, v1, v2, v3}, Lcom/taobao/monitor/impl/trace/c$s;->c(Landroid/app/Activity;Landroid/os/Bundle;J)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/monitor/impl/trace/c$s;

    invoke-virtual {p0, p1}, Lcom/taobao/monitor/impl/trace/c$j;->a(Lcom/taobao/monitor/impl/trace/c$s;)V

    return-void
.end method
