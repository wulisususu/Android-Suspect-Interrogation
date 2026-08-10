.class public Lcom/taobao/monitor/impl/trace/j;
.super Lcom/taobao/monitor/impl/trace/a;
.source "FragmentFunctionDispatcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/k;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/taobao/monitor/impl/trace/a<",
        "Lcom/taobao/monitor/impl/trace/k;",
        ">;",
        "Lcom/taobao/monitor/impl/trace/k;"
    }
.end annotation


# static fields
.field public static final a:Lcom/taobao/monitor/impl/trace/j;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/trace/j;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/trace/j;-><init>()V

    sput-object v0, Lcom/taobao/monitor/impl/trace/j;->a:Lcom/taobao/monitor/impl/trace/j;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/taobao/monitor/impl/trace/a;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V
    .locals 8

    .line 1
    new-instance v7, Lcom/taobao/monitor/impl/trace/j$a;

    move-object v0, v7

    move-object v1, p0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move-wide v5, p4

    invoke-direct/range {v0 .. v6}, Lcom/taobao/monitor/impl/trace/j$a;-><init>(Lcom/taobao/monitor/impl/trace/j;Landroid/app/Activity;Landroidx/fragment/app/Fragment;Ljava/lang/String;J)V

    invoke-virtual {p0, v7}, Lcom/taobao/monitor/impl/trace/a;->a(Lcom/taobao/monitor/impl/trace/a$d;)V

    return-void
.end method
