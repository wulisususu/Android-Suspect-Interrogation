.class Lcom/taobao/monitor/impl/trace/l$g;
.super Ljava/lang/Object;
.source "FragmentLifecycleDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/a$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/trace/l;->b(Landroidx/fragment/app/Fragment;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/monitor/impl/trace/a$d<",
        "Lcom/taobao/monitor/impl/trace/l$o;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic a:Landroidx/fragment/app/Fragment;

.field final synthetic a:Lcom/taobao/monitor/impl/trace/l;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/trace/l;Landroidx/fragment/app/Fragment;J)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/l$g;->a:Lcom/taobao/monitor/impl/trace/l;

    iput-object p2, p0, Lcom/taobao/monitor/impl/trace/l$g;->a:Landroidx/fragment/app/Fragment;

    iput-wide p3, p0, Lcom/taobao/monitor/impl/trace/l$g;->a:J

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/monitor/impl/trace/l$o;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/monitor/impl/trace/l$g;->a:Landroidx/fragment/app/Fragment;

    iget-wide v1, p0, Lcom/taobao/monitor/impl/trace/l$g;->a:J

    .line 2
    invoke-interface {p1, v0, v1, v2}, Lcom/taobao/monitor/impl/trace/l$o;->n(Landroidx/fragment/app/Fragment;J)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/monitor/impl/trace/l$o;

    invoke-virtual {p0, p1}, Lcom/taobao/monitor/impl/trace/l$g;->a(Lcom/taobao/monitor/impl/trace/l$o;)V

    return-void
.end method
