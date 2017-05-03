using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Database;
using Database.Entities;
using System.Collections.Generic;

namespace DatabaseTest {
    [TestClass]
    public class InformerWrapperTest {
        [TestMethod]
        public void GetAllInformersTest() {
            List<Informer> list = InformerWrapper.GetAllInformers();

            Assert.AreEqual(3, list.Count);
            Assert.AreEqual("Elias A. Kristoffersen", list[0].Name);

        }

        [TestMethod]
        public void SaveInformerTest() {
            List<Informer> list = InformerWrapper.GetAllInformers();

            Assert.AreEqual(3, list.Count);

            InformerWrapper.SaveInformer(new Informer("DKK", "Cash", "", -1, "000000-0000", "TST", "TEST"));

            list = InformerWrapper.GetAllInformers();
            Assert.AreEqual(4, list.Count);

        }
    }
}
