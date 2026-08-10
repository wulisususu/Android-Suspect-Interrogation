.class final Lcom/ali/ha/datahub/DataHub$SingleInstanceHolder;
.super Ljava/lang/Object;
.source "DataHub.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/ali/ha/datahub/DataHub;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "SingleInstanceHolder"
.end annotation


# static fields
.field public static final sInstance:Lcom/ali/ha/datahub/DataHub;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 17
    new-instance v0, Lcom/ali/ha/datahub/DataHub;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/ali/ha/datahub/DataHub;-><init>(Lcom/ali/ha/datahub/DataHub$1;)V

    sput-object v0, Lcom/ali/ha/datahub/DataHub$SingleInstanceHolder;->sInstance:Lcom/ali/ha/datahub/DataHub;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
