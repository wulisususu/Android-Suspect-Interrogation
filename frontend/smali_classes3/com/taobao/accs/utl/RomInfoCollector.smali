.class public abstract Lcom/taobao/accs/utl/RomInfoCollector;
.super Ljava/lang/Object;
.source "Taobao"


# instance fields
.field protected mNextCollector:Lcom/taobao/accs/utl/RomInfoCollector;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 4
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getCollector()Lcom/taobao/accs/utl/RomInfoCollector;
    .locals 1

    .line 10
    new-instance v0, Lcom/taobao/accs/utl/e;

    invoke-direct {v0}, Lcom/taobao/accs/utl/e;-><init>()V

    return-object v0
.end method


# virtual methods
.method public abstract collect()Ljava/lang/String;
.end method
