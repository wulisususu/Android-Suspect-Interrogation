.class Lcom/taobao/monitor/impl/trace/d$a;
.super Ljava/lang/Object;
.source "ApplicationBackgroundChangedDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/a$d;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/taobao/monitor/impl/trace/d;->a(IJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/taobao/monitor/impl/trace/a$d<",
        "Lcom/taobao/monitor/impl/trace/d$b;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic a:J

.field final synthetic a:Lcom/taobao/monitor/impl/trace/d;


# direct methods
.method constructor <init>(Lcom/taobao/monitor/impl/trace/d;IJ)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/monitor/impl/trace/d$a;->a:Lcom/taobao/monitor/impl/trace/d;

    iput p2, p0, Lcom/taobao/monitor/impl/trace/d$a;->a:I

    iput-wide p3, p0, Lcom/taobao/monitor/impl/trace/d$a;->a:J

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/monitor/impl/trace/d$b;)V
    .locals 3

    iget v0, p0, Lcom/taobao/monitor/impl/trace/d$a;->a:I

    iget-wide v1, p0, Lcom/taobao/monitor/impl/trace/d$a;->a:J

    .line 2
    invoke-interface {p1, v0, v1, v2}, Lcom/taobao/monitor/impl/trace/d$b;->a(IJ)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/taobao/monitor/impl/trace/d$b;

    invoke-virtual {p0, p1}, Lcom/taobao/monitor/impl/trace/d$a;->a(Lcom/taobao/monitor/impl/trace/d$b;)V

    return-void
.end method
