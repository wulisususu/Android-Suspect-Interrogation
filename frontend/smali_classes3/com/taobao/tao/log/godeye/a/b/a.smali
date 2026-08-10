.class public Lcom/taobao/tao/log/godeye/a/b/a;
.super Ljava/lang/Object;
.source "ClientEvent.java"


# instance fields
.field private a:Ljava/lang/Long;

.field private j:Ljava/lang/String;

.field private value:Ljava/lang/Object;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 12
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(Ljava/lang/Long;Ljava/lang/String;Ljava/lang/Object;)V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/a/b/a;->a:Ljava/lang/Long;

    iput-object p2, p0, Lcom/taobao/tao/log/godeye/a/b/a;->j:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/tao/log/godeye/a/b/a;->value:Ljava/lang/Object;

    return-void
.end method
