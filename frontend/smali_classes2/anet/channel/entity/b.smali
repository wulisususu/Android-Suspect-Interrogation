.class public Lanet/channel/entity/b;
.super Ljava/lang/Object;
.source "Taobao"


# instance fields
.field public final a:I

.field public b:I

.field public c:Ljava/lang/String;


# direct methods
.method public constructor <init>(I)V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lanet/channel/entity/b;->a:I

    return-void
.end method

.method public constructor <init>(IILjava/lang/String;)V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput p1, p0, Lanet/channel/entity/b;->a:I

    iput p2, p0, Lanet/channel/entity/b;->b:I

    iput-object p3, p0, Lanet/channel/entity/b;->c:Ljava/lang/String;

    return-void
.end method
