.class Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$SingleTon;
.super Ljava/lang/Object;
.source "AppLifecycleSubject.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "SingleTon"
.end annotation


# static fields
.field private static INSTANCE:Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 257
    new-instance v0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;-><init>(Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$1;)V

    sput-object v0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$SingleTon;->INSTANCE:Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 256
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic access$000()Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;
    .locals 1

    sget-object v0, Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject$SingleTon;->INSTANCE:Lcom/alibaba/ha/protocol/lifecycle/AppLifecycleSubject;

    return-object v0
.end method
