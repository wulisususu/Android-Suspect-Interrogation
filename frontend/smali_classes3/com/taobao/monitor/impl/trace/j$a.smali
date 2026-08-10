.class Lcom/taobao/monitor/impl/trace/j$a;
.super Ljava/lang/Object;
.source "FragmentFunctionDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/a$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/trace/j;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/monitor/impl/trace/a$d<",
        "Lcom/taobao/monitor/impl/trace/k;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic a:Landroid/app/Activity;

.field final synthetic a:Landroidx/fragment/app/Fragment;

.field final synthetic a:Lcom/taobao/monitor/impl/trace/j;

.field final synthetic a:Ljava/lang/String;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/trace/j;Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/j$a;->a:Lcom/taobao/monitor/impl/trace/j;

    iput-object p2, p0, Lcom/taobao/monitor/impl/trace/j$a;->a:Landroid/app/Activity;

    iput-object p3, p0, Lcom/taobao/monitor/impl/trace/j$a;->a:Landroidx/fragment/app/Fragment;

    iput-object p4, p0, Lcom/taobao/monitor/impl/trace/j$a;->a:Ljava/lang/String;

    iput-wide p5, p0, Lcom/taobao/monitor/impl/trace/j$a;->a:J

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/monitor/impl/trace/k;)V
    .locals 6

    iget-object v1, p0, Lcom/taobao/monitor/impl/trace/j$a;->a:Landroid/app/Activity;

    iget-object v2, p0, Lcom/taobao/monitor/impl/trace/j$a;->a:Landroidx/fragment/app/Fragment;

    iget-object v3, p0, Lcom/taobao/monitor/impl/trace/j$a;->a:Ljava/lang/String;

    iget-wide v4, p0, Lcom/taobao/monitor/impl/trace/j$a;->a:J

    move-object v0, p1

    .line 2
    invoke-interface/range {v0 .. v5}, Lcom/taobao/monitor/impl/trace/k;->a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/monitor/impl/trace/k;

    invoke-virtual {p0, p1}, Lcom/taobao/monitor/impl/trace/j$a;->a(Lcom/taobao/monitor/impl/trace/k;)V

    return-void
.end method
